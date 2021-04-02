$ ->
    deleted = false
    do disable_autoplay = -> # Called immediately
        autoplay = $ 'div.checkbox-on-off, div#head.ytd-compact-autoplay-renderer'
        chkbox = autoplay.find 'input, paper-toggle-button'
        autoplay_btn = $ 'div.ytp-right-controls > button[data-tooltip-target-id="ytp-autonav-toggle-button"]'

        autoplay = null if autoplay.length == 0
        autoplay_btn = null if autoplay_btn.length == 0

        # May not have been loaded yet, try again
        if !deleted and !autoplay? and !autoplay_btn?
            return setTimeout(disable_autoplay, 1000)

        if autoplay? and chkbox?
            chkbox.click() if chkbox.attr 'checked' # Disable autoplay if enabled
            autoplay.remove() # Delete the autoplay div
            deleted = true
        else if autoplay_btn?
            if autoplay_btn.attr('title').search(/is on/gi) == -1
                deleted = true
            else
                autoplay_btn.click()
                # May not have clicked immediately, give it another try
                return setTimeout(disable_autoplay, 1000)

    $(@).on 'spfdone yt-navigate-finish viewport-load', disable_autoplay # Call when the page navigates
