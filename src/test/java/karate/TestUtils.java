package karate;

import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class TestUtils {
    public static boolean replace(final String filePath, final String toBeReplaced, final String replaceWith) {
        try {
            final Path path = Paths.get(TestUtils.class.getClassLoader().getResource(filePath).toURI());
            final Charset charset = StandardCharsets.UTF_8;
            String content = new String(Files.readAllBytes(path), charset);
            content = content.replaceAll(toBeReplaced, replaceWith);
            Files.write(path, content.getBytes(charset));
            return true;
        } catch (IOException | URISyntaxException e) {
            return false;
        }
    }
}
