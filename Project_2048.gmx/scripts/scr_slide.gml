#define scr_slide

//With all blocks
//Stop
with (obj_block) {
    if (!stop) {
        switch (obj_control.slide_dir){
            case "left":
                var dx = -1
                var dy = 0
                break;
            case "right":
                var dx = +1
                var dy = 0
                break;
            case "up":
                var dx = 0
                var dy = -1
                break;
            case "down":
                var dx = 0
                var dy = +1
                break;        
        }
        
        stop = scr_collision_check(dx, dy, id); //Maybe just move this into the switch?
    }
}

//Check if all blocks have stopped
var stop_slide_state = true;
for (i = 0; i < instance_number(obj_block); i += 1) {
    if (!instance_find(obj_block, i).stop) {
        stop_slide_state = false;
        break;
    }
}
if (stop_slide_state) state = scr_post_slide;

#define scr_collision_check
///scr_collision_check(dx, dy, obj)

with (argument2){
    
    var dx = argument0;
    var dy = argument1;
    
    if (place_meeting(x+dx, y+dy, obj_solid)) { //collide with solid
        return(true);
    }
    //collide with other block
    var broman = instance_place(x+dx, y+dy, obj_block);
    if (instance_exists(broman)) {
        if (broman.lvl != lvl) {
            if(broman.stop) return(true);
            if (scr_collision_check(dx, dy, broman)) {
                broman.stop = true;
                return(true);
            }
        }
    }
    return (false);
}