package com.uiuc.profile;

import com.google.android.gms.maps.model.LatLng;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

public class Event {
    Location location;
    String name;
    public static Event create(JSONObject data){
        Event event = null;
        if(data!=null){
            JSONObject locationData = data.optJSONObject("location");
            String name = data.optString("name");
            event = new Event(name, new Location(locationData));
        }

        return event;
    }

    public Event(String name,Location location) {
        this.location = location;
        this.name = name;
    }

    public Location getLocation() {
        return location;
    }

    public String getName(){
        return name;
    }

    public static class Location{
        double lat;
        double lng;
        int floor;
        String description;

        public Location(JSONObject locationData) {
            if(locationData!=null) {
                lat = locationData.optDouble("latitude");
                lng = locationData.optDouble("longtitude");
                floor = locationData.optInt("floor");
                description = locationData.optString("description");
            }
        }

        public double getLat() {
            return lat;
        }

        public double getLng() {
            return lng;
        }

        public int getFloor() {
            return floor;
        }

        public String getDescription() {
            return description;
        }

        public LatLng getPoint(){
            return new LatLng(lat,lng);
        }
    }

    public static class List extends ArrayList<Event>{
        public static List create(JSONArray data){
            List list = new List();
            if (data != null) {
                for(int i = 0; i<data.length();i++){
                    Event event = Event.create(data.optJSONObject(i));
                    list.add(event);
                }
            }
            return list;
        }
    }
}
