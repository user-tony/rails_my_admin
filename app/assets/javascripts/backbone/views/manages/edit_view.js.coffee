RailsAdmin.Views.Manages ||= {}

class RailsAdmin.Views.Manages.EditView extends Backbone.View
  template : JST["backbone/templates/manages/edit"]

  events :
    "submit #edit-manage" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (manage) =>
        @model = manage
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
