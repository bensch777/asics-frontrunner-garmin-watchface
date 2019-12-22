using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application;
using Toybox.ActivityMonitor as Act;

var BatState = Sys.getSystemStats().battery;

	
class ASICSFrontrunnerView extends Ui.WatchFace {

    function initialize() {
        WatchFace.initialize();

    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);
        
        
        // Get and show the current date
        var now = new Toybox.Time.Moment(Time.now().value());
		var today = Time.Gregorian.info(now, Time.FORMAT_MEDIUM);
		//var todayout = Lang.format("$1$, $2$. $3$", [today.day_of_week, today.day, today.month]);
		var todayout = Lang.format("$1$ $2$", [today.day_of_week, today.day]);
		view = View.findDrawableById("DateLabel");
        view.setText(todayout);
		
		// Get and show the current steps
		var activity = Act.getInfo();
		var steps = activity.steps;
		view = View.findDrawableById("StepsLabel");
        view.setText(""+steps+"");
        
        //Bat
        BatState = Sys.getSystemStats().battery;
   
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
