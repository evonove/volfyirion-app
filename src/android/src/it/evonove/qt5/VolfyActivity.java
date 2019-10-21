package it.evonove.qt5;

import it.evonove.volfyirion.R;
import android.app.Activity;
import android.os.Bundle;
import android.os.VibrationEffect;
import android.os.Vibrator;
import android.content.Context;
import android.os.Build;

import android.support.v4.content.ContextCompat;
import android.support.v4.app.ActivityCompat;
import android.Manifest;
import android.content.pm.PackageManager;

public class VolfyActivity extends org.qtproject.qt5.android.bindings.QtActivity
{
    static final int PERMISSION_WRITE_EXTERNAL_STORAGE = 0;

    public VolfyActivity()
    {
        // here we override the default theme with our own
        // which allows us to set status bar color and
        // notification bar color
        QT_ANDROID_THEMES = new String[] {"VolfyTheme"};
        QT_ANDROID_DEFAULT_THEME = "VolfyTheme";
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        setTheme(R.style.VolfyTheme);
        super.onCreate(savedInstanceState);
    }

    public void vibrate() {
        // Check android SDK version to call correct vibrate functions
        // For android API level > 25
        if(android.os.Build.VERSION.SDK_INT > android.os.Build.VERSION_CODES.N_MR1){
            ((Vibrator) getSystemService(Context.VIBRATOR_SERVICE)).vibrate(VibrationEffect.createOneShot(500, 255));
        }
        else {
        // For android API level <= 25
            ((Vibrator) getSystemService(Context.VIBRATOR_SERVICE)).vibrate(500);
        }
    }

    public void saveArtworkImageInPictures() {
        // Check for read and write permission.
        if(ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            System.out.println("Permission is not granted");

            if (ActivityCompat.shouldShowRequestPermissionRationale(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)) {
                System.out.println("ciao");

            } else {
                ActivityCompat.requestPermissions(this, new String[] {Manifest.permission.WRITE_EXTERNAL_STORAGE}, PERMISSION_WRITE_EXTERNAL_STORAGE);
            }
        } else {
            System.out.println("Permission has already been granted");
        }
    }
}
