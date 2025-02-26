from PIL import Image, ImageDraw

def add_return_icon_bottom_left(image_path, output_path):
    """
    Adds a return arrow symbol inside a circle at the bottom-left corner
    of the given image with a transparent background in the circle.
    """
    img = Image.open(image_path).convert("RGBA")
    width, height = img.size

    # Calculate circle size (e.g., 25% of image width)
    circle_diameter = int(width * 0.25)
    circle_radius = circle_diameter // 2

    # Position circle in bottom-left corner
    circle_x = 0  # Left edge
    circle_y = height - circle_diameter  # Align to bottom

    # Make a copy of the image for editing
    base_img = img.copy()
    pixels = base_img.load()

    # Clear only the circular area to make it transparent
    for x in range(circle_x, circle_x + circle_diameter):
        for y in range(circle_y, circle_y + circle_diameter):
            if (x - (circle_x + circle_radius)) ** 2 + (y - (circle_y + circle_radius)) ** 2 <= circle_radius ** 2:
                pixels[x, y] = (255, 255, 255, 0)  # fully transparent

    # Create an overlay for drawing the circle outline and return symbol
    overlay = Image.new("RGBA", base_img.size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(overlay)

    # Draw circle outline
    outline_thickness = 8
    draw.ellipse(
        (circle_x, circle_y, circle_x + circle_diameter, circle_y + circle_diameter),
        outline="black",
        width=outline_thickness
    )

    # Draw the return arrow (a left arrow with a curved tail)
    arrow_thickness = max(4, circle_diameter // 10)
    # Let's define a simple arrow shape
    # e.g. a short horizontal line with a small arrowhead, plus a small curve.

    # The center of the circle
    center_x = circle_x + circle_radius
    center_y = circle_y + circle_radius

    # We'll draw a short line going left
    line_length = circle_radius * 0.6
    start_x = center_x + (line_length / 2)
    end_x = center_x - (line_length / 2)

    # Main arrow line
    draw.line(
        [(start_x, center_y), (end_x, center_y)],
        fill="black",
        width=arrow_thickness
    )

    # Arrowhead pointing left
    arrow_size = arrow_thickness * 1.5
    draw.line(
        [(end_x, center_y + 2), (end_x + arrow_size, center_y - arrow_size)],
        fill="black",
        width=arrow_thickness
    )
    draw.line(
        [(end_x, center_y -2 ), (end_x + arrow_size, center_y + arrow_size)],
        fill="black",
        width=arrow_thickness
    )

    # Optional: add a small arc or curve (like a "return" shape).
    # We'll place a small quarter-circle under the line.
    # The arc center can be near the line’s right side, for example:
    arc_radius = int(circle_radius * 0.4)
    arc_box = [
        start_x - arc_radius,
        center_y,
        start_x + arc_radius,
        center_y + 2 * arc_radius,
    ]
    # This draws a quarter-arc from 180 to 270 degrees
    # draw.arc(arc_box, start=180, end=270, fill="black", width=arrow_thickness)

    # Merge overlay with the base image
    final_img = Image.alpha_composite(base_img, overlay)
    final_img.save(output_path, format="PNG")

if __name__ == "__main__":
    # Example usage:
    input_image = "purchase.png"            # Replace with your actual file name
    output_image = "purchase_return.png"
    add_return_icon_bottom_left(input_image, output_image)
    print(f"Saved output to {output_image}")
