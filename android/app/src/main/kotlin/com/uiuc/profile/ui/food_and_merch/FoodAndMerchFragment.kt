package com.uiuc.profile.ui.food_and_merch

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.uiuc.profile.R
import com.venuenext.vncore.VenueNext
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import kotlinx.coroutines.withContext
import java.lang.Exception

class FoodAndMerchFragment : Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_food_and_merch, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val self = this

        GlobalScope.async {
            try {
                VenueNext.initialize("lulu:prd:demo-01d6eaytpdxrpbeh5mmf0m1192", "4b848e2558c0a76bb289e0f1c643e688ce15473efa14beab03c5f4d518fb1d75", self.context!!).await()
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    findNavController().navigate(R.id.action_main_to_stands)
                }
            }

            withContext(Dispatchers.Main) {
                findNavController().navigate(R.id.action_main_to_stands)
            }
        }
    }
}