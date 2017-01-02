$ ->
    do disable_autoplay = -> # Called immediately
        autoplay = $ 'div.checkbox-on-off, div.ytd-compact-autoplay-renderer'
        chkbox = autoplay.find 'input, paper-toggle-button'

        if autoplay? and chkbox?
            chkbox.click() if chkbox.attr 'checked' # Disable autoplay if enabled
            autoplay.remove() # Delete the autoplay div

    $(@).on 'spfdone yt-navigate-finish viewport-load', disable_autoplay # Call when the page navigates
