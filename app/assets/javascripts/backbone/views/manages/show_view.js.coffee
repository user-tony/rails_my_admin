RailsAdmin.Views.Manages ||= {}

class RailsAdmin.Views.Manages.ShowView extends Backbone.View
  template: JST["backbone/templates/manages/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
