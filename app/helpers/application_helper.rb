module ApplicationHelper
  def applied_filters
    filters = {}
    filters = params.require(:search).permit(%w[listing social_network user text start_date end_date]).delete_if { |k, v| v.blank? }.to_h
    filters = filters.map { |k, v| [k, (%w[text start_date end_date].include?(k) ? v : k.camelize.constantize.find(v).name)] }.to_h
    filters.map{|k,v| "#{k == 'User' ? 'Author' : k.humanize}: #{v}"}.join(', ')
  end
end
