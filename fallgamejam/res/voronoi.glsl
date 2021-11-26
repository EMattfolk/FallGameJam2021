vec2 points[3] = vec2[](
        vec2(100, 100),
        vec2(300, 300),
        vec2(100, 400)
);

vec4 colors[3] = vec4[](
        vec4(1, 0, 1, 1),
        vec4(1, 1, 1, 1),
        vec4(0, 0, 1, 1)
);


float distance_squared(vec2 p1, vec2 p2) {
        vec2 diff = p2 - p1;
        return dot(diff, diff);
}

vec4 effect(vec4 color, Image texture, vec2 tc, vec2 pixel_coord) {
        float min_dist_sq = distance_squared(pixel_coord, points[0]);
        vec4 nearest_color = colors[0];

        for (int i = 1; i < 3; i++) {
                float dist_sq = distance_squared(pixel_coord, points[i]);
                if (dist_sq < min_dist_sq) {
                        min_dist_sq = dist_sq;
                        nearest_color = colors[i];
                }
        }

        return nearest_color;
}
