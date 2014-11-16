class window.SubmittedView
  constructor: (@farm) ->
    @render()

  render: ->
    $('body').html(
      @template(name: @farm.name)
    )
    @renderFinishedMap()  

  template: ->
    """
      <div class="container clearfix">
        <p class="you-submitted">You submitted this boundary</p>
        <a class="claim-url" href="#">http://example.com/3478357835</a>
      </div>
    """

  renderFinishedMap: ->
    #TODO