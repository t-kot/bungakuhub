class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^([a-z0-9._-]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$/i
      record.errors[attribute] << I18n.t("errors.messages.email")
    end
  end
end
