import $ from 'jquery';

async function waitForElement(selector: string): Promise<JQuery<HTMLElement>> {
    return new Promise(resolve => {
        if ($(selector).length) {
            return resolve($(selector));
        }

        const observer = new MutationObserver(() => {
            if ($(selector).length) {
                resolve($(selector));
                observer.disconnect();
            }
        });

        observer.observe(document.body, {
            childList: true,
            subtree: true
        });
    });
}

function disableAutoplay() {
    waitForElement('div.ytp-right-controls > button[data-tooltip-target-id="ytp-autonav-toggle-button"]')
        .then((autoplayToggle) => {
            // If autoplay is currently enabled, click the toggle
            if (autoplayToggle.attr('aria-label')?.search(/is on/gi) !== -1) {
                autoplayToggle.trigger('click');
                setTimeout(disableAutoplay, 1000);  // Keep retrying until we're sure it's off
            } else {
                // disabled now, so delete switch
                autoplayToggle.remove();
            }
        })
        .catch((err) => {
            console.log(`Error finding autoplay element: ${err}\nRetrying...`);
            setTimeout(disableAutoplay, 1000);
        });
}

$(() => {
    disableAutoplay();
    $(document).on('spfdone yt-navigate-finish viewport-load', disableAutoplay);
});
