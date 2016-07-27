{Point, Range, TextBuffer} = require 'atom'
ExploratorySegment = require './exploratory-segment'

'''
Segment view represents the visual appearance of a Segment, and contains a
Segment object.
'''
module.exports =
class ExploratorySegmentView
  model : null
  currentVariant : null
  variantsDiv : null
  # pinned
  pinned : false # in general is the pin button active
  pinnedToTop : false
  pinnedToBottom : false
  # div that contains variant display
  variantBox_forward : null
  variantBox_back: null

  constructor: (editor, original_buffer, marker, segmentTitle) ->
    @model = new ExploratorySegment(@, editor, original_buffer, marker, segmentTitle)
    @currentVariant = @model.getCurrentVariant()
    @addVariantsDiv()

  getModel: ->
    @model

  getDiv: ->
    @variantsDiv

  openVariantsDiv: ->
    #if $(@variantBox_forward).children().length > 0
    $(@variantBox_forward).slideToggle(500)
    #if $(@variantBox_back).children().length > 0
    $(@variantBox_back).slideToggle(500)

  newVariant: ->
    newVariant = @model.newVariant()
    newVarDiv = newVariant.getDiv()
    $(newVarDiv).hide()
    @variantBox_forward.appendChild(newVarDiv)
    c_div = @currentVariant.getDiv()
    c_header = @currentVariant.getHeader()
    $(newVarDiv).addClass('variant')
    $(newVariant.getHeader()).addClass('activeVariant')
    $(c_div).addClass 'inactive_variant', complete: ->
      $(c_header).removeClass('activeVariant')
      $(c_header).addClass('inactiveVariant')
      $(newVarDiv).slideToggle 'slow'


  addVariantsDiv: ->
    #container for entire block
    @variantsDiv = document.createElement('div')
    @variantsDiv.classList.add('atomic-taro_editor-exploratory-variants')
    #---------variants upper region
    @addVariantsDiv_Back()
    @addVariantsDiv_Forward()
    @variantsDiv.appendChild(@variantBox_forward)
    #--------- add all the segments
    @variantsDiv.appendChild(@currentVariant.getDiv())
    #---------variants lower div
    @variantsDiv.appendChild(@variantBox_back)


  addVariantHeaderDiv: (headerContainer) ->
    nameContainer = document.createElement("div")
    nameContainer.classList.add('atomic-taro_editor-header-name-container')
    boxHeader = document.createElement("div")
    boxHeader.classList.add('atomic-taro_editor-header-name')
    $(boxHeader).text("variant 1")
    nameContainer.appendChild(boxHeader)
    #add placeholder for data
    dateHeader = document.createElement("div")
    $(dateHeader).text("created 7/14/19 5:04pm")
    dateHeader.classList.add('atomic-taro_editor-header-date.variant')
    nameContainer.appendChild(dateHeader)
    headerContainer.appendChild(nameContainer)

  addVariantsDiv_Forward: ->
    @variantBox_forward = document.createElement("div")
    @variantBox_forward.classList.add('variants-container-forward')
    $(@variantBox_forward).hide()

  addVariantsDiv_Back: ->
    @variantBox_back = document.createElement("div")
    @variantBox_back.classList.add('variants-container-back')

    varHeader = document.createElement("div")
    varHeader.classList.add('variants-header-box')
    @addVariantHeaderDiv(varHeader)
    #@addOutputButton(varHeader)
    @variantBox_back.appendChild(varHeader)

    varHeader1 = document.createElement("div")
    varHeader1.classList.add('variants-header-box', 'inactive')
    @addVariantHeaderDiv(varHeader1)
    #@addOutputButton(varHeader1)
    @variantBox_back.appendChild(varHeader1)

    varHeader2 = document.createElement("div")
    varHeader2.classList.add('variants-header-box')
    @addVariantHeaderDiv(varHeader2)
    #@addOutputButton(varHeader2)
    @variantBox_back.appendChild(varHeader2)
    $(@variantBox_back).hide()