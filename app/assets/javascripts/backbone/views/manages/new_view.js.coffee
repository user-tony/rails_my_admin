RailsAdmin.Views.Manages ||= {}

class RailsAdmin.Views.Manages.NewView extends Backbone.View
  template: JST["backbone/templates/manages/new"]

  events:
    "submit #new-manage": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (manage) =>
        @model = manage
        window.location.hash = "/#{@model.id}"

      error: (manage, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
