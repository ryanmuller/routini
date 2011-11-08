module ContextsHelper
  def context_options
    options = []
    current_user.contexts.each do |c|
      options << [c.name, c.id]
    end
    return options
  end
end
