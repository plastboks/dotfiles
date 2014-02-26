//!javascript 
// open current URL in firefox

function openInFirefox() {
    system.spawn("sh -c 'firefox -new-tab \"" + tabs.current.uri + "\"'");
}

bind(null, openInFirefox, "open_in_firefox");
