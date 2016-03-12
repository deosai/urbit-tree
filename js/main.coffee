rend = ReactDOM.render

$ ->
  util = require './utils/util.coffee'
  require './utils/scroll.coffee'


  # we load modules that may need to send actions up, so we attach
  # the actions to window here.
  window.tree.actions = require './actions/TreeActions.coffee'

  # reactify has virtual components which themselves need to call 
  # reactify.  to do this, we register the components after the fact
  window.tree.actions.addVirtual require './components/Components.coffee'

  frag = util.fragpath window.location.pathname.replace /\.[^\/]*$/,''
  window.tree.actions.setCurr frag 
  window.tree.actions.loadPath frag,window.tree.data
  window.urb.ondataupdate = (dep)->
    for dat of window.urb.datadeps
      window.urb.dewasp(dat)
    window.tree.actions.clearData()
  
  main = React.createFactory require './components/TreeComponent.coffee'
  rend (main {}, ""),document.getElementById('tree')
