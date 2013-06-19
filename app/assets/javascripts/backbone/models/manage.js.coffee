class RailsAdmin.Models.Manage extends Backbone.Model
  paramRoot: 'develop_rails_admin_manage'

  defaults:
  	name: null
  	id: ''

class RailsAdmin.Collections.ManagesCollection extends Backbone.Collection
  model: RailsAdmin.Models.Manage
  url: '/develop/rails_admin/manages'
