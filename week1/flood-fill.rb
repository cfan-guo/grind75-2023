# https://leetcode.com/problems/flood-fill/
# [Easy]
#
# Unfortunately I actually vaguely remember doing this
# it's some BFS bullshit with arrays which means I'm definitely
# going to travel out of bounds, yay
#
# Actually managed to one-shot it, nice
#
# @param {Integer[][]} image
# @param {Integer} sr
# @param {Integer} sc
# @param {Integer} color
# @return {Integer[][]}
def flood_fill(image, sr, sc, color)
  # easy out
  return image if image[sr][sc] == color

  flood(image, sr, sc, image[sr][sc], color)

  image
end

def flood(image, r, c, init_color, new_color)
  # check out of bounds
  return if r < 0 || r > image.length - 1
  return if c < 0 || c > image[0].length - 1

  # check if we're working with the same colour before flooding
  if image[r][c] == init_color
    image[r][c] = new_color
    flood(image, r+1, c, init_color, new_color)
    flood(image, r-1, c, init_color, new_color)
    flood(image, r, c+1, init_color, new_color)
    flood(image, r, c-1, init_color, new_color)
  end
end
