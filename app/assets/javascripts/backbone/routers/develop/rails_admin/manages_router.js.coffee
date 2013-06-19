class RailsAdmin.Routers.ManagesRouter extends Backbone.Router
  initialize: (options) ->
    @manages = new RailsAdmin.Collections.ManagesCollection()
    @manages.reset options.manages

  routes:
    "/new"      : "newDevelop"
    "list"     : "list"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newDevelop: ->
    @view = new RailsAdmin.Views.Manages.NewView(collection: @manages)
    $("#manages").html(@view.render().el)

  index: ->
    @view = new RailsAdmin.Views.Manages.IndexView(manages: @manages)
    $("#manages").html(@view.render().el)

  list: ->
    @view = new RailsAdmin.Views.Manages.ListView(manages: @manages)
    $("#manages").html(@view.render().el)

  show: (id) ->
    manage = @manages.get(id)

    @view = new RailsAdmin.Views.Manages.ShowView(model: manage)
    $("#manages").html(@view.render().el)

  edit: (id) ->
    manage = @manages.get(id)

    @view = new RailsAdmin.Views.Manages.EditView(model: manage)
    $("#manages").html(@view.render().el)
