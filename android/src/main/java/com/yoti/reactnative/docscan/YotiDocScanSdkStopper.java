package com.yoti.reactnative.docscan;

import android.app.Activity;
import android.app.Application;
import android.app.Application.ActivityLifecycleCallbacks;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.List;

public class YotiDocScanSdkStopper implements ActivityLifecycleCallbacks {

    private final static String YDS_PACKAGE_NAME = "com.yoti.mobile.android";
    private final static String FACETEC_PACKAGE_NAME = "com.facetec.sdk";
    private final static int YDS_ACTIVITY_FINISH_RESULT = Activity.RESULT_FIRST_USER + 1;

    private final List<Activity> sdkActivities = new ArrayList<>();

    @Nullable
    private Application application = null;

    public void init(@NonNull final Application application) {
        sdkActivities.clear();
        application.registerActivityLifecycleCallbacks(this);
        this.application = application;
    }

    public void stopSdk(boolean animated) {
        for (int i = sdkActivities.size() - 1; i >= 0; i--) {
            finishActivity(sdkActivities.get(i), !animated);
        }
    }

    public void cleanup() {
        if (application != null) {
            application.unregisterActivityLifecycleCallbacks(this);
            application = null;
        }
        sdkActivities.clear();
    }

    @Override
    public void onActivityPreCreated(@NonNull final Activity activity, @Nullable final Bundle savedInstanceState) {
        if (isSdkActivity(activity)) {
            sdkActivities.add(activity);
        }
    }

    @Override
    public void onActivityCreated(@NonNull final Activity activity, @Nullable final Bundle savedInstanceState) {
        // N/A
    }

    @Override
    public void onActivityStarted(@NonNull final Activity activity) {
        // N/A
    }

    @Override
    public void onActivityResumed(@NonNull final Activity activity) {
        // N/A
    }

    @Override
    public void onActivityPaused(@NonNull final Activity activity) {
        // N/A
    }

    @Override
    public void onActivityStopped(@NonNull final Activity activity) {
        // N/A
    }

    @Override
    public void onActivitySaveInstanceState(@NonNull final Activity activity, @NonNull final Bundle outState) {
        // N/A
    }

    @Override
    public void onActivityDestroyed(@NonNull final Activity activity) {
        // N/A
    }

    @Override
    public void onActivityPostDestroyed(@NonNull final Activity activity) {
        if (isSdkActivity(activity)) {
            sdkActivities.remove(activity);
        }
    }

    private boolean isSdkActivity(@NonNull final Activity activity) {
        return isYdsActivity(activity) || isFacetecActivity(activity);
    }

    private boolean isYdsActivity(@NonNull final Activity activity) {
        return isInPackage(activity, YDS_PACKAGE_NAME);
    }

    private boolean isFacetecActivity(@NonNull final Activity activity) {
        return isInPackage(activity, FACETEC_PACKAGE_NAME);
    }

    private boolean isInPackage(@NonNull final Activity activity, @NonNull final String packageName) {
        return activity.getLocalClassName().startsWith(packageName);
    }

    private void finishActivity(@NonNull final Activity activity, boolean disableTransitionAnimations) {
        if (isYdsActivity(activity)) {
            activity.setResult(YDS_ACTIVITY_FINISH_RESULT);
        }
        activity.finish();
        if (disableTransitionAnimations) {
            activity.overridePendingTransition(0, 0);
        }
    }
}