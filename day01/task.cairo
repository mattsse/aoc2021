%builtins output range_check
from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.math_cmp import is_le


# counts how many increased values are included in the puzzle
func num_increased_part1{range_check_ptr : felt}(puzzle : felt*, idx, size) -> (num):
    alloc_locals
    local increased
    if idx == size:
        return (num=0)
    end

    let (lower_or_eq) = is_le{range_check_ptr=range_check_ptr}(a=[puzzle], b=[puzzle - 1])
    if lower_or_eq == 1:
        increased = 0
    else:
        increased = 1
    end

    let (rem) = num_increased_part1(puzzle=puzzle + 1, idx=idx+1, size=size)
    return (num = increased + rem )
end

# counts how many increased values are included in the puzzle using a sliding window
func num_increased_part2{range_check_ptr : felt}(puzzle : felt*, idx, size) -> (num):
    alloc_locals
    local increased
    const window = 3

    if idx + window == size:
        return (num=0)
    end
    let x = [puzzle + 3]
    let current_window = [puzzle] + [puzzle + 1] + [puzzle + 2]
    let next_window = [puzzle + 1]+ [puzzle + 2] + [puzzle + 3]

    let (lower_or_eq) = is_le{range_check_ptr=range_check_ptr}(a=next_window, b=current_window)
    if lower_or_eq == 1:
        increased = 0
    else:
        increased = 1
    end

    let (rem) = num_increased_part2(puzzle=puzzle + 1, idx=idx+1, size=size)
    return (num = increased + rem )
end

func main{output_ptr : felt*, range_check_ptr : felt,}():
    alloc_locals
    local puzzle_len : felt
    local puzzle : felt*
    %{ 
        import aocutil
        puzzle = aocutil.read_ints("input1.txt")
        ids.puzzle_len = segments.gen_arg(len(puzzle))
        ids.puzzle = segments.gen_arg(puzzle)
    %}
    # let (increased) = num_increased_part1(puzzle=puzzle+1, idx=1, size=puzzle_len)
    let (increased) = num_increased_part2(puzzle=puzzle, idx=0, size=puzzle_len)

    serialize_word(increased)

    return ()
end