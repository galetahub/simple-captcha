if Object.const_defined?("Formtastic")
  if Formtastic.const_defined?("FormBuilder")
    CUSTOM_FORM_BASE_CLASS = Formtastic::FormBuilder
  else
    CUSTOM_FORM_BASE_CLASS = Formtastic::SemanticFormBuilder
  end
end
