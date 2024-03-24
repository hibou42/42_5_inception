<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inception Bitches!</title>
	<link rel="stylesheet" href="<?php echo get_template_directory_uri(); ?>/style.css">
    <?php wp_head(); ?>
</head>
<body>
    <header>
        <div class="wrapper">
            <h1><?php bloginfo('name'); ?></h1>
        </div>
    </header>

    <nav>
        <?php wp_nav_menu(array('theme_location'=>'primary')); ?>
    </nav>

    <div class="wrapper">
        <article>
            <!-- Custom table content display starts here -->
            <?php
            global $wpdb;
            $table_name = 'posts'; // Change to your actual table name
            $custom_posts = $wpdb->get_results("SELECT * FROM {$table_name}", OBJECT);

            if(!empty($custom_posts)) {
                foreach($custom_posts as $post) {
                    echo '<div class="custom-post">';
                    echo '<h2>' . esc_html($post->title) . '</h2>';
                    echo '<div>' . esc_html($post->content) . '</div>';
                    echo '<time datetime="' . esc_attr($post->published_at) . '">' . esc_html(date('F j, Y, g:i a', strtotime($post->published_at))) . '</time>';
                    echo '</div>';
                }
            } else {
                echo '<p>No posts found.</p>';
            }
            ?>
            <!-- Custom table content display ends here -->

            <!-- Standard WordPress loop for posts -->
            <?php if(have_posts()) : while(have_posts()) : the_post(); ?>
                <h2><?php the_title(); ?></h2>
                <?php the_content(); ?>
            <?php endwhile; endif; ?>
        </article>
    </div>

    <footer>
        <p>Footer in your face!</p>
    </footer>

    <?php wp_footer(); ?>
</body>
</html>
