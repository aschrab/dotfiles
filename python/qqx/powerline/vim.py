from powerline.theme import requires_segment_info
from powerline.bindings.vim import vim_get_func

@requires_segment_info
def current_char(segment_info):
    try:
        pos = segment_info['window'].cursor
        char = segment_info['buffer'][ pos[0]-1 ][ pos[1] ]
        return "0x%02X" % ord(char)
    except Exception, e:
        return "0x00"
