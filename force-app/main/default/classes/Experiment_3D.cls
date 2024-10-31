/**
 * This class is intentionallly empty.
 * Its purpose is to demonstrate that Subscriber classes that DO NOT touch the managed package 
 * WILL NOT automatically get ANY `<packageVersions>` metadata added to its `.cls-meta.xml` file.
 */
public class Experiment_3D {
    public Experiment_3D() {
        System.debug('This is intentionally empty.');
    }   
}