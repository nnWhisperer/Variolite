{Point, Range, TextBuffer} = require 'atom'


module.exports =
class CommitTravelAgent

  constructor: (@atomicTaroView) ->
    @mainMenuHeader = null
    @outputPane = null


  '''
    added later after the master variant initializes
  '''
  setMasterVariant: (master) ->
    @masterVariant = master
    @mainMenuHeader = @masterVariant.getHeaderElement()


  '''
    added later after the output pane initializes
  '''
  setOutputPane: (out) ->
    @outputPane = out


  travelToGlobalCommit: (commit) ->
    # check if we are in the current state or in the past
    # make sure the editor is not editable
    # travel text of master variant and set all nested variants back

    # update all commit lines to show which commit we're on
    # update all branch maps to show which branch each variant is on
    # show a lock icon that makes it clear that you cannot editor
    # have the option to show this past whatever into an editable branch
    # compare/diff

    # update the main menu to show the new commit
    @mainMenuHeader.showAlertPane(commit)

    @masterVariant.getModel().travelToCommit(commit)
    # style all variants so it's clear we're in the past
    @masterVariant.travelStyle(commit)
    @setEnvToCommit(@masterVariant, commit)



  globalBackToFuture: (variant) ->
    @masterVariant.getModel().travelToCommit({})
    @masterVariant.removeTravelStyle()
    @resetEnvToPresent()


  '''
    Any variant can call this method. This is at the global program level so that
    we can coordinate multiple components, such as the output pane and diffs.
  '''
  resetEnvToPresent: ->
    @outputPane.resetToPresent()
    #@mainMenuHeader.hideAlertPane()


  setEnvToCommit: (variant, commitData) ->
    @outputPane.setToCommit(variant, commitData)
    #@mainMenuHeader.showAlertPane(commitData.commitID)
    # DO SOMETHING
