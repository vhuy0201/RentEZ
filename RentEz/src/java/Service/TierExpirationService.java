package Service;

import DAO.UserTierDAO;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * Background service to automatically expire tier memberships
 * Runs every hour to check and update expired memberships
 */
@WebListener
public class TierExpirationService implements ServletContextListener {
    
    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Initialize the scheduler when the application starts
        scheduler = Executors.newScheduledThreadPool(1);
        
        // Schedule the tier expiration task to run every hour
        scheduler.scheduleAtFixedRate(new TierExpirationTask(), 0, 1, TimeUnit.HOURS);
        
        System.out.println("TierExpirationService started - checking expired memberships every hour");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Shutdown the scheduler when the application stops
        if (scheduler != null) {
            scheduler.shutdown();
            try {
                if (!scheduler.awaitTermination(60, TimeUnit.SECONDS)) {
                    scheduler.shutdownNow();
                }
            } catch (InterruptedException e) {
                scheduler.shutdownNow();
                Thread.currentThread().interrupt();
            }
        }
        System.out.println("TierExpirationService stopped");
    }

    /**
     * Task that checks and expires old tier memberships
     */
    private static class TierExpirationTask implements Runnable {
        @Override
        public void run() {
            try {
                UserTierDAO userTierDAO = new UserTierDAO();
                boolean updated = userTierDAO.updateExpiredTiers();
                
                if (updated) {
                    System.out.println("TierExpirationTask: Updated expired tier memberships at " + 
                                     new java.util.Date());
                }
            } catch (Exception e) {
                System.err.println("Error in TierExpirationTask: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
}
