#define scr_slide

//Count frames

tick_count ++;
if (tick_count = 4) tick_count = 0;

//If tick count is 0, combine blocks, and check which blocks should stop
if (tick_count = 0) {
    //Combine blocks
    for (var i = 0; i < instance_number(obj_block)-1; i += 1) {
        var mario = instance_find(obj_block, i);
        for (var j = i+1; j < instance_number(obj_block); j += 1) {
            var broman = instance_find(obj_block, j);
            if !(broman.lvl = mario.lvl && broman.x = mario.x && broman.y = mario.y) continue;
            with (broman) instance_destroy();
            mario.stop = true;
            mario.combine_lock = true;
            mario.frozen = false;
            mario.lvl += 1;
            mario.sprite_index = spr_block
            mario.image_index = mario.lvl - 1;
        }
    }
    //Do trash things
    with (obj_trash) {
        var broman = instance_position(x, y, obj_block);
        with (broman) instance_destroy();
    }
    
    //End level
    with (obj_end_level) {
        var broman = instance_position(x, y, obj_block);
        with (broman) room_goto_next();
    }
    
    //All blocks collision
    with (obj_block) {
        if (!stop) {
            switch (obj_control.slide_dir){
                case "left":
                    var dx = -7
                    var dy = 0
                    break;
                case "right":
                    var dx = +6
                    var dy = 0
                    break;
                case "up":
                    var dx = 0
                    var dy = -7
                    break;
                case "down":
                    var dx = 0
                    var dy = +6
                    break;
            }
            
            stop = scr_stop_check(dx, dy, id); //Maybe just move this into the switch?
        }
    }
    
    //Check if all blocks have stopped/ end slide-state
    var stop_slide_state = true;
    for (var i = 0; i < instance_number(obj_block); i += 1) {
        if (!instance_find(obj_block, i).stop) {
            stop_slide_state = false;
            break;
        }
    }
    if (stop_slide_state) {
        state = scr_post_slide;
        exit;
    }
}

//Move all blocks every frame. This is the only thing that happens when !(tick_count=0)
with (obj_block){
    if (!stop){
        switch (obj_control.slide_dir) {
            case "left":
                x -= 3;
                break;
            case "right":
                x += 3;
                break;
            case "up":
                y -= 3;
                break;
            case "down":
                y += 3;
                break;
        }
    }
}

#define scr_stop_check
///scr_stop_check(dx, dy, obj)

with (argument2){
    
    var dx = argument0;
    var dy = argument1;
    
    //collide with solid
    var broman = instance_position(x+dx, y+dy, obj_solid);
    if (instance_exists(broman)) {
        if (broman.lvl != lvl) return(true);
    }
    //collide with other block
    var broman = instance_position(x+dx, y+dy, obj_block);
    if (instance_exists(broman)) {
        if (broman.lvl != lvl or broman.combine_lock or lvl = 0) {
            if(broman.stop) return(true);
            if (scr_stop_check(dx, dy, broman)) {
                broman.stop = true;
                return(true);
            }
        }
    }
    return (false);
}