# frozen_string_literal: true

class DocumentService
  attr_reader :manufactors, :cats, :certs

  def initialize
    @manufactors = []
    @cats = []
    @certs = []
  end

  def catalogs
    Dir['public/catalogs/*'].map do |cat|
      filename = cat.split('/').last
      manufactor, doc = filename.split('_')

      if manufactors.present? && manufactors.include?(manufactor)
        doc_containder = cats.detect { |c| c[:manufactor] == manufactor }
        doc_containder[:docs] << { name: doc.split('.').first,
                                   path: "/#{cat.split('/')[1..-1].join('/')}" }
      else
        manufactors << manufactor
        cats << { manufactor: manufactor,
                  docs: [{ name: doc.split('.').first,
                           path: "/#{cat.split('/')[1..-1].join('/')}" }] }
      end
    end
    cats
  end

  def certificates
    Dir['public/certificates/*'].map do |cert|
      filename = cert.split('/').last

      certs << { docs: [{ name: filename.split('.').first,
                          path: "/#{cert.split('/')[1..-1].join('/')}" }] }
    end
    certs
  end
end
