if ('OTPCredential' in window) {
    window.addEventListener('DOMContentLoaded', e => {
        navigator.credentials.get({
            otp: { transport: ['sms'] },
        }).then(otp => {

            const webOtpAutofillEvent = new CustomEvent('web-otp-autofill', {
                detail: {
                    otp: otp.code
                }
            });

            window.dispatchEvent(webOtpAutofillEvent);

        }).catch(err => {
            console.log(err);
        });
    });
}