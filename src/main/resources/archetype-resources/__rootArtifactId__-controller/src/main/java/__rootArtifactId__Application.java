package ${package};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Spring Boot Application 启动入口
 * 
 * @author ${user}
 */
@SpringBootApplication
public class ${rootArtifactId}Application {

    public static void main(String[] args) {
        SpringApplication.run(${rootArtifactId}Application.class, args);
    }
}
