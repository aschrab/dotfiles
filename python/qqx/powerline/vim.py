from powerline.theme import requires_segment_info
from powerline.bindings.vim import getbufvar
from powerline.lib import add_divider_highlight_group

@requires_segment_info
def current_char(segment_info, **extra):
    try:
        pos = segment_info['window'].cursor
        char = segment_info['buffer'][ pos[0]-1 ][ pos[1] ]
        return "0x%02X" % ord(char)
    except Exception:
        return "0x00"

@requires_segment_info
@add_divider_highlight_group('background:divider')
def file_encoding(segment_info, expected=['utf-8'], unknown_text='unknown', **extra):
    '''Return file encoding/character set.

    :return: file encoding/character set or None if unknown or missing file encoding

    Divider highlight group used: ``background:divider``.
    '''
    enc = getbufvar(segment_info['bufnr'], '&fileencoding')

    if enc in expected:
        return None
    else:
        if enc:
            return enc
        else:
            return unknown_text

@requires_segment_info
@add_divider_highlight_group('background:divider')
def file_format(segment_info, expected=['unix'], unknown_text='unknown', **extra):
    '''Return file format (i.e. line ending type).

    :return: file format or None if unknown or missing file format

    Divider highlight group used: ``background:divider``.
    '''

    fmt = getbufvar(segment_info['bufnr'], '&fileformat')

    if fmt in expected:
        return None
    else:
        return fmt or unknown_text
@requires_segment_info
def line_count(segment_info, **extra):
    '''Return the number of lines in the file'''
    lines = len(segment_info['buffer'])
    return str(lines)
