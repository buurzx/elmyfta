class OrganizationValidationService
  attr_accessor :params, :errors

  def initialize(params)
    @params = params
    @errors = []
  end

  # organization: {
  #   org_name: "ООО Друф2",
  #   inn: "12312312319",
  #   city: "Нижний Тагил",
  #   address: "Зари, 99-165.",
  #   site: "",
  #   description: "",
  #   contact: "Василий",
  #   email: "er@er.er",
  #   phone: ""
  # }

  def validation
    organization_validation
    user_validation
    params
  end

  private

  def user_validation
    user = User.find_by(email: params['email'])
    errors!('Пользователь с таким email уже зарегистрирован.') if user
  end

  def organization_validation
    orgs = Organization.where(name: params['org_name'], inn: params['inn'])
    errors!('Такая организация уже существует.') if orgs.present?

    return unless errors.empty?

    org = Organization.new(name: params['org_name'], inn: params['inn'])
    errors!(org.errors.full_messages) unless org.valid?
  end

  def errors!(msg)
    if msg.is_a? Array
      msg.each { |m| @errors << m }
    else
      @errors << msg
    end
  end
end
