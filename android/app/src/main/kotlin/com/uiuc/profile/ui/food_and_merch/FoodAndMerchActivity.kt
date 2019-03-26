/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

package com.uiuc.profile.ui.food_and_merch

import android.os.Bundle
import android.view.Gravity
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import androidx.navigation.findNavController
import com.uiuc.profile.R

class FoodAndMerchActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_food_and_merch)
        showUpNavigationButton()
        centerActionBarTitle()
    }

    /**
     * Manually bring the user back from android content to flutter content
     */
    override fun onBackPressed() {
        val fmHomeFragmentId = R.id.standsFragment
        val currentDestId = findNavController(R.id.fragment_food_and_merch).currentDestination?.id
        if (currentDestId == fmHomeFragmentId) {
            finish()
        } else {
            super.onBackPressed()
        }
    }

    /**
     * Handle up (back) navigation button clicked
     */
    override fun onOptionsItemSelected(item: MenuItem?): Boolean {
        onBackPressed()
        return true
    }

    private fun centerActionBarTitle() {
        val toolbar = findViewById<Toolbar>(R.id.action_bar)
        if (toolbar != null) {
            val textView = toolbar.getChildAt(0)
            if (textView != null) {
                val layoutParams = Toolbar.LayoutParams(
                    Toolbar.LayoutParams.WRAP_CONTENT,
                    Toolbar.LayoutParams.WRAP_CONTENT
                )
                layoutParams.gravity = Gravity.CENTER
                textView.layoutParams = layoutParams
            }
        }
    }

    private fun showUpNavigationButton() {
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        supportActionBar?.setDisplayShowHomeEnabled(true)
    }
}