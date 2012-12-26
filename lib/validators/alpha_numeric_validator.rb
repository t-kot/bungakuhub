class AlphaNumericValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^[a-zA-Z0-9]+$/
      record.errors[attribute] << I18n.t("errors.messages.alphanumeric")
    end
  end
end
