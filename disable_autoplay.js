// Generated by CoffeeScript 2.3.2
(function() {
  $(function() {
    var deleted, disable_autoplay;
    deleted = false;
    (disable_autoplay = function() { // Called immediately
      var autoplay, chkbox;
      autoplay = $('div.checkbox-on-off, div#head.ytd-compact-autoplay-renderer');
      chkbox = autoplay.find('input, paper-toggle-button');
      // May not have been loaded yet, try again
      if (!deleted && autoplay.length === 0) {
        return setTimeout(disable_autoplay, 1000);
      }
      if ((autoplay != null) && (chkbox != null)) {
        if (chkbox.attr('checked')) { // Disable autoplay if enabled
          chkbox.click();
        }
        autoplay.remove(); // Delete the autoplay div
        return deleted = true;
      }
    })();
    return $(this).on('spfdone yt-navigate-finish viewport-load', disable_autoplay); // Call when the page navigates
  });

}).call(this);