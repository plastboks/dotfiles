//!javascript
//<userscripts___SCRIPT
extensions.load("userscripts", {
//<userscripts___CONFIG
  // paths to userscripts, this extension will also load all scripts in 
  // $XDG_CONFIG_HOME/dwb/greasemonkey, it will also load all scripts in
  // $XDG_CONFIG_HOME/dwb/scripts but this is deprecated and will be
  // disabled in future versions.
  scripts : []
//>userscripts___CONFIG
});
//>userscripts___SCRIPT
//<autoquvi___SCRIPT
extensions.load("autoquvi", {
//<autoquvi___CONFIG
// The quvi command
quvi      : "quvi",  

// External player command
player    : "mplayer %u", 

// Whether to automatically play videos if quvi finds a playable
// video
autoPlay  : true, 

// Whether to choose the quality before quvi starts
chooseQuality : true,

// A shortcut that spawns quvi for the current website
shortcut  : "",

// A command that spawns quvi for the current website 
command  : "autoquvi", 

// 
// Whether to autospawn quvi only in the active tab
activeOnly : true 

//>autoquvi___CONFIG
});
//>autoquvi___SCRIPT
