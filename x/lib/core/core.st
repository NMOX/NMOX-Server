Smalltalk.NMOX defineClass: #Element
    superclass: #{Core.Object}
    indexedType: #none
    private: false
    instanceVariableNames: 'tagName attributes children'
    classInstanceVariableNames: ''
    imports: ''
    category: 'NMOX-HTMLBuilder'!

!Element methodsFor: 'initialization'!
initialize: aTagName
    tagName := aTagName.
    attributes := Dictionary new.
    children := OrderedCollection new.
!

!Element methodsFor: 'accessing'!
setAttribute: aName value: aValue
    attributes at: aName put: aValue.
!

appendChild: aChild
    children add: aChild.
!

render
    self subclassResponsibility.
!

!Element class methodsFor: 'instance creation'!
new: aTagName
    ^self new initialize: aTagName.
!

Smalltalk.NMOX defineClass: #HTMLElement
    superclass: #Element
    indexedType: #none
    private: false
    instanceVariableNames: ''
    classInstanceVariableNames: ''
    imports: ''
    category: 'NMOX-HTMLBuilder'!

!HTMLElement methodsFor: 'rendering'!
render
    | attributesStr childrenStr |
    attributesStr := ' ' join: (attributes associations collect: [:each |
        each key, '="', each value, '"']).
    childrenStr := '' join: (children collect: [:each | each render]).
    ^'<', tagName, ' ', attributesStr, '>', childrenStr, '</', tagName, '>'.
!

Smalltalk.NMOX defineClass: #TextNode
    superclass: #Element
    indexedType: #none
    private: false
    instanceVariableNames: 'text'
    classInstanceVariableNames: ''
    imports: ''
    category: 'NMOX-HTMLBuilder'!

!TextNode methodsFor: 'initialization'!
initialize: aText
    super initialize: ''.
    text := aText.
!

!TextNode methodsFor: 'rendering'!
render
    ^text.
!

!TextNode class methodsFor: 'instance creation'!
new: aText
    ^self new initialize: aText.
!
