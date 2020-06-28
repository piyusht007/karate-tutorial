package karate;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.Assert.assertTrue;

@KarateOptions(tags = {"@integration-test", "~@ignore"})
public class TestParallel {

    @Test
    public void testParallel() {
        Results results = Runner.parallel(getClass(), 5, "target/surefire-reports");
        TestParallel.generateReport(results.getReportDir());
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }

    public static void generateReport(String karateOutputPath) {
        final Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        final List<String> jsonPaths = new ArrayList(jsonFiles.size());

        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));

        final Configuration config = new Configuration(new File("target"), "karateTesting");
        final ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
