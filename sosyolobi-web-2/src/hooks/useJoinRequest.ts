import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { userApiClient } from "@/lib/user-api-client";
import type { ActivityJoinRequest } from "@/types/user";

export function useJoinRequest(activityId: string | null) {
  const qc = useQueryClient();

  const join = useMutation({
    mutationFn: (message?: string) =>
      userApiClient<ActivityJoinRequest>(`/api/activities/${activityId}/requests`, {
        method: "POST",
        body: JSON.stringify({ message }),
      }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["activity", activityId] }),
  });

  const cancel = useMutation({
    mutationFn: (requestId: string) =>
      userApiClient<null>(`/api/activity-requests/${requestId}/cancel`, { method: "POST" }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["activity", activityId] }),
  });

  return { join, cancel };
}

export function useIncomingRequests() {
  const qc = useQueryClient();

  const query = useQuery({
    queryKey: ["requests-incoming"],
    queryFn: () => userApiClient<ActivityJoinRequest[]>("/api/activity-requests/incoming"),
    staleTime: 15_000,
  });

  const approve = useMutation({
    mutationFn: (requestId: string) =>
      userApiClient<null>(`/api/activity-requests/${requestId}/approve`, { method: "POST" }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["requests-incoming"] }),
  });

  const reject = useMutation({
    mutationFn: (requestId: string) =>
      userApiClient<null>(`/api/activity-requests/${requestId}/reject`, { method: "POST" }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["requests-incoming"] }),
  });

  return { ...query, approve, reject };
}

export function useSentRequests() {
  return useQuery({
    queryKey: ["requests-sent"],
    queryFn: () => userApiClient<ActivityJoinRequest[]>("/api/activity-requests/sent"),
    staleTime: 15_000,
  });
}
