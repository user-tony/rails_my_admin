RailsAdmin.Views.Manages ||= {}

class RailsAdmin.Views.Manages.ManageView extends Backbone.View
  template: JST["backbone/templates/manages/manage"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
