package com.aboydfd.jenkins_docker_demo;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import static org.junit.Assert.assertEquals;

@RunWith(SpringRunner.class)
@SpringBootTest
public class JenkinsDockerDemoApplicationTests {

    @Test
    public void contextLoads() {
    }

    @Test
    public void shouldFail() {
        assertEquals("expected value","wrong value");
    }

}
