///Look for key press
var wrongkey = false;
if (keyboard_check_pressed(vk_anykey)) {
    switch (keyboard_key) {
        case vk_left:
        case ord("A"):
           slide_dir = "left";
           break;
        case vk_right:
        case ord("D"):
           slide_dir = "right";
           break;
        case vk_up:
        case ord("W"):
           slide_dir = "up";
           break;
        case vk_down:
        case ord("S"):
           slide_dir = "down";
           break;
        default:
            wrongkey = true;
    }
    
    if (!wrongkey) {
        with (obj_block) {
            if (!frozen) stop = false;
            else stop = true;
            // ---- Setting: blocks stuck after combine inside gates
            var broman = instance_position(x, y, obj_solid);
            if (instance_exists(broman)) if (broman.lvl != lvl) stop = true;
            // ---- */
            combine_lock = false
        }
        tick_count = -1;
        state = scr_slide;
        scr_slide();
    }
}
