# frozen_string_literal: true

class DocumentService
  attr_reader :manufactors, :cats, :certs

  def initialize
    @manufactors = []
    @cats = []
    @certs = []
  end

  def catalogs
    Dir['public/catalogs/*'].map! { |cat| handle_catalog(cat) }

    cats
  end

  def certificates
    Dir['public/certificates/*'].map! do |cert|
      filename = cert.split('/').last

      certs << { docs: [{ name: filename.split('.').first,
                          path: "/#{cert.split('/')[1..-1].join('/')}" }] }
    end
    certs
  end

  private

  def handle_catalog(cat)
    filename = cat.split('/').last
    manufactor, doc = filename.split('_')

    if manufactors.present? && manufactors.include?(manufactor)
      manufactors_doc(doc, manufactor, cat)
    else
      manufactors << manufactor
      add_catalog(doc, manufactor, cat)
    end
  end

  def manufactors_doc(doc, manufactor, cat)
    doc_container = cats.detect { |c| c[:manufactor] == manufactor }
    doc_container[:docs] << doc_object(doc, cat)
  end

  def add_catalog(doc, manufactor, cat)
    cats << { manufactor: manufactor,
              docs:       [doc_object(doc, cat)] }
  end

  def doc_object(doc, cat)
    { name: doc.split('.').first,
      path: "/#{cat.split('/')[1..-1].join('/')}" }
  end
end
