package com.yoti.reactnative.docscan;

import android.app.Activity;
import android.content.Intent;
import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.BaseActivityEventListener;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.yoti.mobile.android.yotisdkcore.YotiSdk;
import static com.yoti.mobile.android.yotisdkcore.YotiSdkKt.YOTI_SDK_REQUEST_CODE;

public class RNYotiDocScanModule extends ReactContextBaseJavaModule {
    private final static int SESSION_SUCCESS_CODE = 0;
    private YotiSdk mYotiSdk;
    private Callback mErrorCallback;
    private Callback mSuccessCallback;
    private int mRequestCode = YOTI_SDK_REQUEST_CODE;

    private final ActivityEventListener mActivityEventListener = new BaseActivityEventListener() {
        @Override
        public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent intent) {
            if (requestCode != mRequestCode) {
                return;
            }
            int code = mYotiSdk.getSessionStatusCode();
            String description = mYotiSdk.getSessionStatusDescription();
            if (resultCode == Activity.RESULT_OK && code == SESSION_SUCCESS_CODE && mSuccessCallback != null) {
                mSuccessCallback.invoke(code, description);
                return;
            }
            if (mErrorCallback != null) {
                mErrorCallback.invoke(code, description);
            }
        }
    };

    RNYotiDocScanModule(ReactApplicationContext reactContext) {
        super(reactContext);
        reactContext.addActivityEventListener((mActivityEventListener));
        mYotiSdk = new YotiSdk(reactContext).configureReactNativeClient();
    }

    @Override
    public String getName() {
        return "RNYotiDocScan";
    }

    @ReactMethod
    public void useCanadaService() {
        mYotiSdk.useCanadaService();
    }

    @ReactMethod
    public void setPrimaryColorRGB(double red, double green, double blue) {
        // Required to maintain cross-platform API compatibility.
    }

    @ReactMethod
    public void setRequestCode(int requestCode) {
        mRequestCode = requestCode;
    }

    @ReactMethod
    public void startSession(String sessionId, String clientSessionToken, Callback successCallback, Callback errorCallback) {
        mErrorCallback = errorCallback;
        mSuccessCallback = successCallback;
        Activity currentActivity = getCurrentActivity();
        if (currentActivity == null) {
            mErrorCallback.invoke("E_ACTIVITY_DOES_NOT_EXIST");
            return;
        }
        boolean success = mYotiSdk.setSessionId(sessionId).setClientSessionToken(clientSessionToken).start(currentActivity, mRequestCode);
        if (!success) {
            int code = mYotiSdk.getSessionStatusCode();
            String description = mYotiSdk.getSessionStatusDescription();
            mErrorCallback.invoke(code, description);
        }
    }
}
