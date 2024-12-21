import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

@SuppressWarnings({"unchecked", "rawtypes"})
public class _Launch {
    public static void main(String[] args) {
        clearTerminal();
        findAndInvokeMain(args);
    }

    private static void clearTerminal() {
        System.out.print("\033[H\033[2J");
        System.out.flush();
    }

    private static void findAndInvokeMain(String[] args) {
        Class mainClass = getMainClass();
        if (mainClass != null) {
            try {
                mainClass.getMethod("main", String[].class).invoke(null, (Object) args);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private static Class getMainClass() {
        Class[] classes = getClasses();
        for (Class c : classes) {
            if (containsPublicStaticMainMethod(c) && c != _Launch.class) {
                return c;
            }
        }
        return null;
    }

    private static Class[] getClasses() {
        Package myPackage = _Launch.class.getPackage();
        String packageName = myPackage.getName();
        try {
            return getClasses(packageName);
        } catch (ClassNotFoundException | IOException e) {
            e.printStackTrace();
			return new Class[0];
        }
    }

    private static Class[] getClasses(String packageName) throws ClassNotFoundException, IOException {
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        assert classLoader != null;
        String path = packageName.replace('.', '/');
        Enumeration<URL> resources = classLoader.getResources(path);
        List<File> dirs = new ArrayList<>();
        while (resources.hasMoreElements()) {
            URL resource = resources.nextElement();
            dirs.add(new File(resource.getFile()));
        }
        ArrayList<Class> classes = new ArrayList<>();
        for (File directory : dirs) {
            classes.addAll(findClasses(directory, packageName));
        }
        return classes.toArray(new Class[classes.size()]);
    }

    private static List<Class> findClasses(File directory, String packageName) throws ClassNotFoundException {
        List<Class> classes = new ArrayList<>();
        if (!directory.exists()) {
            return classes;
        }
        File[] files = directory.listFiles();
        for (File file : files) {
            if (file.isDirectory()) {
                assert !file.getName().contains(".");
                classes.addAll(findClasses(file, packageName + "." + file.getName()));
            } else if (file.getName().endsWith(".class")) {
                String simpleClassName = file.getName().substring(0, file.getName().length() - 6);
                String fullClassName = packageName.isEmpty() ? simpleClassName : packageName + '.' + simpleClassName;
                classes.add(Class.forName(fullClassName));
            }
        }
        return classes;
    }

    private static boolean containsPublicStaticMainMethod(Class c) {
        try {
            Method m = c.getMethod("main", String[].class);
            if (m.getReturnType() != void.class) {
                return false;
            }
            return m.canAccess(null);
        } catch (NoSuchMethodException e) {
            return false;
        }
    }
}
