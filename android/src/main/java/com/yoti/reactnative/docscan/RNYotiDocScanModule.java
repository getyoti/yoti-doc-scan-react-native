package com.yoti.reactnative.docscan;

import android.app.Activity;
import android.content.Intent;
import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.BaseActivityEventListener;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReactMethod;
import com.yoti.mobile.android.yotisdkcore.YotiSdk;
import static com.yoti.mobile.android.yotisdkcore.YotiSdkKt.YOTI_SDK_REQUEST_CODE;

public class RNYotiDocScanModule extends ReactContextBaseJavaModule {
    private final static int SESSION_SUCCESS_CODE = 0;
    private YotiSdk mYotiSdk;
    private Callback mCompletion;
    private int mRequestCode = YOTI_SDK_REQUEST_CODE;

    private final ActivityEventListener mActivityEventListener = new BaseActivityEventListener() {
        @Override
        public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent intent) {
            if (requestCode != mRequestCode) {
                return;
            }
            int code = mYotiSdk.getSessionStatusCode();
            String description = mYotiSdk.getSessionStatusDescription();
            if (resultCode == Activity.RESULT_OK && code == SESSION_SUCCESS_CODE) {
                mCompletion.invoke(code, description);
                return;
            }
            mCompletion.invoke(code, description);
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
    public void setConfiguration(ReadableMap configuration) {
        // Required to maintain cross-platform API compatibility.
    }

    @ReactMethod
    public void setRequestCode(int requestCode) {
        mRequestCode = requestCode;
    }

    @ReactMethod
    public void start(String sessionID, String sessionToken, Callback completion) {
        mCompletion = completion;
        Activity currentActivity = getCurrentActivity();
        if (currentActivity == null) {
            mCompletion.invoke("E_ACTIVITY_DOES_NOT_EXIST");
            return;
        }
        boolean success = mYotiSdk.setSessionId(sessionID).setClientSessionToken(sessionToken).start(currentActivity, mRequestCode);
        if (!success) {
            int code = mYotiSdk.getSessionStatusCode();
            String description = mYotiSdk.getSessionStatusDescription();
            mCompletion.invoke(code, description);
        }
    }
}
