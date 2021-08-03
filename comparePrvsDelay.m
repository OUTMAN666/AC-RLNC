clc;
clear;
close all;

th = 0;

N=100;
p_vec=0.8:-0.1:0.1;
%p_vec=0;
RTT=16; % Feedback Delay is 15 time slot
k = RTT-1;

iter=1000;
% ExDelay_SS=zeros(iter,length(p_vec));
% ExDelay_SA=zeros(iter,length(p_vec));
% ExDelay_SA_LB=zeros(iter,length(p_vec));
% 
% ExDelay_Queue=zeros(iter,length(p_vec));
% ExDelay_MV=zeros(iter,length(p_vec));
% ExDelay_2StepSearch=zeros(iter, length(p_vec));
% ExDelay_2StepSearch_upper=zeros(iter, length(p_vec));

ExDelay_ACRLNC = zeros(iter,length(p_vec));

for i=1:length(p_vec)
    p = p_vec(i)
    
    for j=1:iter
        
%         ExDelay_SS(j,i)=simuSS_FB(N,p,RTT);
%         ExDelay_SA(j,i)=simuSA_FB(N,p,RTT);
%         ExDelay_SA_LB(j,i)=simuDelayedFB_SA_LB(N,p,RTT);
%         ExDelay_Queue(j,i)=simuQueue_FB(N,p,RTT);
%         ExDelay_MV(j,i)=simuMV_FB(N,p,RTT);
%         ExDelay_2StepSearch(j,i)=simuDStepSearch_FB(N,p,RTT,2);
%         ExDelay_2StepSearch_upper(j,i)=simuDStepSearch_FB_Upper(N,p,RTT,2);
        ExDelay_ACRLNC(j,i)=getACRLNC(th,N,RTT,p);
    end
end

% ExDelay_Queue_mean=sum(ExDelay_Queue,1)/iter;
% ExDelay_MV_mean=sum(ExDelay_MV,1)/iter;
% ExDelay_2StepSearch_mean=sum(ExDelay_2StepSearch,1)/iter;
% ExDelay_SS_mean=sum(ExDelay_SS,1)/iter;
% ExDelay_SA_mean=sum(ExDelay_SA,1)/iter;
% ExDelay_2StepSearch_upper_mean=sum(ExDelay_2StepSearch_upper,1)/iter;
% ExDelay_2StepSearch_avg=min([ExDelay_2StepSearch_mean;ExDelay_2StepSearch_upper_mean]);

ExDelay_ACRLNC_mean = mean(ExDelay_ACRLNC,1);

plot(p_vec,ExDelay_ACRLNC_mean,'bo-','MarkerFaceColor','b');

% figure;
% plot(p_vec,ExDelay_Queue_mean,'md-','MarkerFaceColor','m');
% 
% hold on;
% plot(p_vec,ExDelay_SS_mean,'bo-','MarkerFaceColor','b');
% 
% plot(p_vec,ExDelay_SA_mean,'gv-','MarkerFaceColor','g');
% 
% plot(p_vec,ExDelay_MV_mean,'rs-','MarkerFaceColor','r');
% %plot(p_vec,ExDelay_SA_LB_mean,'kp-','MarkerFaceColor','k');
% plot(p_vec,ExDelay_2StepSearch_avg,'kp-','MarkerFaceColor','k');
% hold off;
% legend('Feedback-based Adaptive Coding','Single-State','Single-Action','Majority Vote','2-Step Search');
% xlabel('Packet Erasure Probability');
% ylabel('Expected End-to-End Delay');
% grid on;
% save erasure6.mat

% % save FB_results_N100.mat;
% filename=['FB_results_N',num2str(N),'_iter',num2str(iter),'.mat'];
% save(filename);
