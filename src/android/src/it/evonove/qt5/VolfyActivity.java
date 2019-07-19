package it.evonove.qt5;

import it.evonove.volfyirion.R;
import android.app.Activity;
import android.os.Bundle;

public class VolfyActivity extends org.qtproject.qt5.android.bindings.QtActivity
{
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
}
