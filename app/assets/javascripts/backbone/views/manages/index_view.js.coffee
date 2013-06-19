RailsAdmin.Views.Manages ||= {}

class RailsAdmin.Views.Manages.IndexView extends Backbone.View
  template: JST["backbone/templates/manages/index"]

  initialize: () ->
    @options.manages.bind('reset', @addAll)

  addAll: () =>
    @options.manages.each(@addOne)

  addOne: (manage) =>
    view = new RailsAdmin.Views.Manages.ManageView({model : manage})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(manages: @options.manages.toJSON() ))
    @addAll()

    return this
