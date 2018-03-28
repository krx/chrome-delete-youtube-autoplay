$ ->
    deleted = false
    do disable_autoplay = -> # Called immediately
        autoplay = $ 'div.checkbox-on-off, div.ytd-compact-autoplay-renderer'
        chkbox = autoplay.find 'input, paper-toggle-button'

        # May not have been loaded yet, try again
        if not deleted and autoplay.length == 0
            return setTimeout(disable_autoplay, 1000)

        if autoplay? and chkbox?
            chkbox.click() if chkbox.attr 'checked' # Disable autoplay if enabled
            autoplay.remove() # Delete the autoplay div
            deleted = true

    $(@).on 'spfdone yt-navigate-finish viewport-load', disable_autoplay # Call when the page navigates
