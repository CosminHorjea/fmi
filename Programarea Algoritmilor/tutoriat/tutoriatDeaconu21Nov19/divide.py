m = [
    [0] * 6,
    [0] * 6,
    [0, 0, 1, 0, 0, 0],
    [0] * 6,
    [0] * 6,
    [0] * 6,
]

# 0 ->
#       22
#       20
#
# 1 ->
#       22
#       12
#
# 2 ->
#       12
#       22
#
# 3 ->
#       21
#       22


def cover(m, p1, p2, start, start_type):
    width = p2[0] - p1[0] + 1
    height = p2[1] - p1[1] + 1
    if width < 2 or height < 2:
        return None
    x, y = start
    if start_type == 0:
        starts = [
            start, (x, y + 1),
            (x + 1, y), (x + 1, y + 1)
        ]
    elif start_type == 1:
        starts = [
            (x - 1, y), start,
            (x - 1, y - 1), (x - 1, y)
        ]
    elif start_type == 2:
        starts = [
            (x - 1, y), (x - 1, y + 1),
            start, (x, y + 1)
        ]
    else:
        starts = [
            (x - 1, y - 1), (x - 1, y),
            (x, y - 1), start
        ]
    cover(m, p1, starts[0], starts[0], 2)
    cover(m, (p1[0], start[1][1]), (start[0][0], p2[1]), starts[1], 3)
    cover(m, (starts[3][0], p1[1]), (p2[0], starts[3][1]), starts[3], 1)
    cover(m, starts[2], p2, starts[2], 0)
